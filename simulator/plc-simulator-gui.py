import requests
import random
import PySimpleGUI as sg

def get_machine_ids(api_base, window):
    export_endpoint = f"{api_base}/machines-export.php"
    try:
        window['-LOG-'].update(f"Fetching machines from {export_endpoint}...\n", append=True)
        response = requests.get(f"{export_endpoint}?format=csv", timeout=3)
        response.raise_for_status()
        csv_data = response.text.strip()
        if not csv_data:
            return []
        ids = [int(x) for x in csv_data.split(',')]
        window['-LOG-'].update(f"Loaded {len(ids)} machines: {ids}\n", append=True, text_color_for_value='lightgreen')
        return ids
    except Exception as e:
        window['-LOG-'].update(f"Error fetching machines: {e}\n", append=True, text_color_for_value='red')
        return []

def main():
    sg.theme('DarkBlue3')

    layout = [
        [sg.Text('MES API Base URL:'), sg.InputText('http://localhost:8082/mes/api', key='-URL-', size=(40, 1))],
        [sg.Button('Start Simulation', button_color='green', key='-START-'), 
         sg.Button('Stop Simulation', button_color='red', key='-STOP-', disabled=True)],
        [sg.Multiline(size=(60, 15), key='-LOG-', disabled=True, font='Courier 10', background_color='black', text_color='white')]
    ]

    window = sg.Window('WAGO PLC Simulator', layout)
    is_running = False
    machine_ids = []

    while True:
        event, values = window.read(timeout=300) 

        if event == sg.WIN_CLOSED:
            break

        if event == '-START-':
            api_base = values['-URL-'].strip()
            machine_ids = get_machine_ids(api_base, window)
            if machine_ids:
                is_running = True
                window['-START-'].update(disabled=True)
                window['-STOP-'].update(disabled=False)
                window['-URL-'].update(disabled=True)
                window['-LOG-'].update("--- SIMULATION RUNNING ---\n", append=True, text_color_for_value='yellow')
            else:
                window['-LOG-'].update("Cannot start: No machines found.\n", append=True, text_color_for_value='red')

        if event == '-STOP-':
            is_running = False
            window['-START-'].update(disabled=False)
            window['-STOP-'].update(disabled=True)
            window['-URL-'].update(disabled=False)
            window['-LOG-'].update("--- SIMULATION STOPPED ---\n", append=True, text_color_for_value='salmon')

        if event == sg.TIMEOUT_EVENT and is_running:
            machine_id = random.choice(machine_ids)
            count = random.randint(1, 70)
            payload = {'machine_id': machine_id, 'production_count': count}
            
            try:
                res = requests.post(f"{values['-URL-'].strip()}/wago-receive.php", json=payload, timeout=2)
                if res.status_code == 200:
                    msg = f"Machine #{machine_id} -> {count} parts (SUCCESS)\n"
                    window['-LOG-'].update(msg, append=True)
                else:
                    msg = f"Machine #{machine_id} -> FAILED ({res.status_code})\n"
                    window['-LOG-'].update(msg, append=True, text_color_for_value='orange')
            except requests.exceptions.RequestException as e:
                window['-LOG-'].update(f"CONNECTION ERROR: {e}\n", append=True, text_color_for_value='red')

    window.close()

if __name__ == '__main__':
    main()