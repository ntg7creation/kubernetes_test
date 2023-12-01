from fastapi import FastAPI
from fastapi.responses import HTMLResponse
import os
app = FastAPI()


def generate_html_response():
    #there must be a better way to do this
    f = open('/code/app/bitcoin_price.html','r') 
    html = f.read()
    f.close()
    html_content = html
    return HTMLResponse(content=html_content, status_code=200)


@app.get("/", response_class=HTMLResponse)
async def read_items():
    return generate_html_response()