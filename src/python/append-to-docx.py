#!/usr/bin/env python3
# usage: python src/python/append-to-docx.py requirements_doc .
import sys
import os
import urllib.request, json 
import docx
from docx import Document
from docx.shared import Cm
from docx.enum.text import WD_ALIGN_PARAGRAPH
from io import StringIO



full_path, table, path, app, db, user, ht_protocol, web_host, web_port = '', '', '', '', '', '', '', '', ''
def main():
    set_vars()
    tableData = getTableData(None)
    buildDoc(table,tableData)
    sys.exit()


def set_vars():
    try:
        global full_path, table, path, app, db, user, ht_protocol, web_host, web_port
        table = sys.argv[1]
        full_path = str(sys.argv[2] or '.')
        app = os.environ['postgres_db_name']
        db = os.environ['postgres_db_name']
        user= os.environ['postgres_db_user']
        ht_protocol = os.environ['ht_protocol']
        web_host= os.environ['web_host']
        web_port = os.environ['port']
    except(IndexError) as error:
        print (error) 
        traceback.print_stack()
        sys.exit(1)

    return


def getTableData(url):
       
    if ( url == None):
        url = ht_protocol + "://" + web_host + ":" + web_port + "/" + app + "/hiselect/" + table + "?pg-size=10000&bid=0"
    try:
        with urllib.request.urlopen(url) as url:
            data = json.loads(url.read().decode())
            # debug print(data)
    except (Exception) as error:
        print(error)
    finally:
        return data['dat']


def buildDoc(table,tableData):
    doc = Document(full_path) # open an existing document with existing styles
    #debug print('Loaded {}'.format(tableData))
    for row in tableData:
        print ('row {}'.format(row))
        level = row['level']
        if ( level == 0 ):
            continue
        if ( level == 1 ):
            levelStyle = 'style-kone-blue-heading-01'
        else: 
            levelStyle = 'Heading ' + str(level)
        title = row['name']
        heading = doc.add_heading( title , level)
        heading.style = doc.styles[levelStyle]
        p = doc.add_paragraph(row['description'])
        if row['src']:
            src = doc.add_paragraph(row['src'])
            src.style = doc.styles['Body Text 3']
        if row['formats']:
            formats = json.loads(row['formats'])
            if formats:
                listing_url = formats['listing-url']
                listingData = getTableData(listing_url)
                #for style in doc.styles:
                    #print ( style )
                doc_table = doc.add_table(1, 2, doc.styles['Table Grid'])
                for lrow in listingData:
                    cells = doc_table.add_row().cells
                    cells[0].text = lrow['name'] 
                    cells[1].text = lrow['description'] 
        if row['img_http_path']:
            ip = doc.add_paragraph()
            r = ip.add_run()
            r.add_text(row['img_name'])
            r.add_text("\n")
            r.add_picture(row['img_http_path'], width = Cm(15.0))

    doc.save(full_path)
    return 0


main()
