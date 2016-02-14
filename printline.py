import Tkinter
import threading
import Queue

top = Tkinter.Tk()
coordQueue = Queue.Queue()


xMax = int(0)
xMin = int(0)
yMax = int(0)
yMin = int(0)
xStart = int(0)
yStart = int(0)
xSize = int(0)
ySize = int(0)

xPrev = int(0)
yPrev = int(0)

first = True

point = 100, 400
coordQueue.put(point)

#coordQueue.get(1)

def addline(point):
    x = point[0]
    y = point[1]

    global marg, yMax, xMax, yMin, xMin, xStart, yStart, xSize, ySize

    marg = int(10)

    if y > yMax:
        yMax = y
    if y < yMin:
        yMin = y
    if x > xMax:
        xMax = x
    if x < xMin:
        xMin = x

    xStart = xMin - xMin*(marg/100)
    yStart = yMin - yMin*(marg/100)
    xSize = (xMax + xMax*(marg/100)) - xStart
    ySize = (yMax + yMax*(marg/100)) - yStart

    line = xPrev, yPrev, x, y

    C = Tkinter.Canvas(top, bg="white", height=xSize, width=ySize)
    C.create_line(line)
    C.pack()

    top.mainloop()
def checkQueue():
    print "jaman checkQueue"
    if coordQueue.not_empty:
        for i in list(coordQueue.queue):
            point = coordQueue.get(i)
            addline(point)
            break

def myLineThread():
    print "Jaman myLineThread"
    try:
        threading.Timer(1.0, checkQueue()).start()
    except Exception, st:
        print "threadingen is knas: %s" % st
try:
    print "Sista try"
    myLineThread()
except Exception, e:
    print "Addline fungerar inte: %s" % e

