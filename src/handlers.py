""" Endpoint Callback Handlers """

from datetime import datetime

def greeter():
    """Greeter route callback"""
    now = datetime.now()
    current_datetime = now.strftime("%m/%d/%Y, %H:%M:%S")

    return f"<p>Hello World! <p> Current time:  {current_datetime}!"
