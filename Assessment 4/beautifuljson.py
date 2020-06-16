#!/usr/bin/python3

import pandas as  pd

df = pd.read_json (r'./response.json')
export_csv = df.to_csv (r'./response.csv', index=None, header=True)

