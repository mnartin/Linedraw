# coding=utf-8
import socket
import sys
import json
import Tkinter
import Queue
import threading
from thread import *

## http://stackoverflow.com/questions/4685217/parse-raw-http-headers ##
from BaseHTTPServer import BaseHTTPRequestHandler
from StringIO import StringIO

class HTTPRequest(BaseHTTPRequestHandler):
    def __init__(self, request_text):
        self.rfile = StringIO(request_text)
        self.raw_requestline = self.rfile.readline()
        self.error_code = self.error_message = None
        self.parse_request()

    def send_error(self, code, message):
        self.error_code = code
        self.error_message = message
##################################################



host = ''
port = 8001
serversocket = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
top = Tkinter.Tk()
coordQueue = Queue.Queue()

try:
    serversocket.bind((host, port))
except socket.error as msg:
    print 'Gick inte att binda, fixa'
    sys.exit()

serversocket.listen(5) # Börjar lyssna på socketen

def recievingthread(conn):
    while True:
        data = conn.recv(1024)
        reply = '204 No Content'
        # Gör något med datan här brush
        if data:
            try:
                request = HTTPRequest(data)
                if request.command != 'PUT':
                    exit_thread("Jaman det är fel meddelande")
                try:
                    #coord = json.loads(request.rfile.read(request.headers.getparam(2)))
                    request.data_string = request.rfile.read(int(request.headers['Content-Length']))
                    coord = json.loads(request.data_string)
                    #print (coord)

                except Exception, e:
                    print "Något fel med inläsningen: %s" % e

                if len(coord) is 2:
                    # Skicka in skit i utskrivningsgrejen av fönstret och grejer
                    print(coord)
                    #TODO Sätta in myLineThread här?

            except ValueError as msg:
                print 'ingen jsonfil skickades'

            print data
            # Här har datat tagits igenom genom socketen,
            # Läs in det som JSON och skicka upp det i fönstret
            try:
                xCoord = (coord['X'])
                yCoord = (coord['Y'])
                koordinater = xCoord, yCoord
                coordQueue.put(koordinater)

            except ValueError as msg:
                print "Det gick inte att få in koordinaterna"
        conn.sendall(reply)
        break
    conn.close()

while True:
    conn, addr = serversocket.accept()
    print 'address för connection: ' + addr[0]
    start_new_thread(recievingthread, (conn,))
serversocket.close()





def myLineThread():
    def checkQueue():
        if coordQueue.not_empty:
            for i in range(0, len(coordQueue)):
                point = coordQueue.get(i)
                addline(point)
                break
    threading.Timer(1.0, checkQueue).start()


### Inklistrat från printfunktionen ###
xMax = int(0)
xMin = int(0)
yMax = int(0)
yMin = int(0)
xStart = int(0)
yStart = int(0)
xSize = int(0)
ySize = int(0)

# Gör helst om till en 2darray sen (xPrev, yPrev = [int()][int()])
xPrev = int(0)
yPrev = int(0)

#Hårdkodning suger ju
first = True

#PrintFunktionen... behövs 'C' som inputargument i funktionen?

def addline(point):
    x = point[0]
    y = point[1]

    global marg, yMax, xMax, yMin, xMin, xStart, yStart, xSize, ySize

    # kantmarginal i procent
    marg = int(10)

    # Funktion för att förändra skalan samt marginalerna på ritytan
    if y > yMax:
        yMax = y
    if y < yMin:
        yMin = y
    if x > xMax:
        xMax = x
    if x < xMin:
        xMin = x

    # Bestämmer marginalerna för kanvasen
    xStart = xMin - xMin*(marg/100)
    yStart = yMin - yMin*(marg/100)
    xSize = (xMax + xMax*(marg/100)) - xStart
    ySize = (yMax + yMax*(marg/100)) - yStart

    line = xPrev, yPrev, x, y

    C = Tkinter.Canvas(top, bg="white", height=xSize, width=ySize)
    C.create_line(line)
    C.pack()

    top.mainloop()
