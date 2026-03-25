# Python Code to extract CSV data from GDX

1. Create a virtual environment and activate it:
```bash
   python -m virtualenv venv
   source venv/bin/activate  # On Windows use `./venv/Scripts/activate`
```
2. Install the required packages:
```bash
   pip install -r requirements.txt
```
3. Run the script to extract data from GDX files:
```bash
   python extract_gdx.py g20_43.gdx
```