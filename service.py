"""Entry point of our microservice. API endpoints (routes) are defined here.
 """

#pylint: disable=unused-import
import logging as log

from flask import Flask, request, Response
from src import handlers

# pylint: disable=invalid-name
app = Flask(__name__)

@app.route('/', methods=['GET'])
def say_hello():
    """ Greeter Endpoint"""
    resp = handlers.greeter()
    return Response(resp, mimetype='text/html')


if __name__ == '__main__':
    app.run(debug=True, host='0.0.0.0')
