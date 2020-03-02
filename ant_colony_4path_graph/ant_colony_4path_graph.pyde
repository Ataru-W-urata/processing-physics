## display pathをいかに美しく実現するか
## アリの動きを少しランダムウォークっぽくする

randomSeed(4)
PHEROM_VAL = [1.1, 1.2, 1.3, 1.4]
DIST_VAL = [1, 1.1, 1.2, 1.3]
ALPH = 1     # alpha: weighting parameter for pheromone val
BETA = 1     # beta : weighting parameter for heuristic val
RHO = 0.5  # evaporation rate

# parameters for displaying path and graph
pathWidth = 400
graphHeight = 350
graphWidth = 350
total = [[0],[0],[0],[0]]
freq = [[],[],[],[]]

def setup():
    frameRate(4)
    size(800, 400)
    background(255)
    global ant
    ant = Ant()
    
    # display path
    for i in range(len(PHEROM_VAL)):        
        strokeWeight(20)
        stroke(220)
        line(10, height/2, pathWidth/2, height/5*(i+1))
        line(pathWidth/2, height/5*(i+1), pathWidth-10, height/2)
    
def draw():
    
    ant.initiate()
    ant.activate()
    updatePherom()
    #string = "PHEROMONE: {0}, {1}, {2}, {3}".format(PHEROM_VAL[0],PHEROM_VAL[1],PHEROM_VAL[2],PHEROM_VAL[3])
    #println(string)
        
    displayPath()
    displayGraph()
    
def updatePherom():
    delta_tau = ant.deposit()
    for i in range(len(PHEROM_VAL)):
        PHEROM_VAL[i] = (1.0-RHO)*PHEROM_VAL[i] + delta_tau[i]
        if(PHEROM_VAL[i]<0.05):
            PHEROM_VAL[i] = 0.05
            

def displayPath():
        
    i = ant.selected_edge  
    push()
    
    if(i==0):   r=100;g=0;b=0
    elif(i==1): r=0;g=100;b=0
    elif(i==2): r=0;g=0;b=100
    else:       r=0;g=0;b=0
    
    stroke(r,g,b)
    strokeWeight(1.5)
    x1 = 10; y1 = height/2; x2 = pathWidth/2; y2 = height/5*(i+1); x3 = pathWidth-10; y3 = height/2
    x = [x1]
    y = [y1]
    for j in range(20):
        x.append(lerp(x1, x2, j/20.0)+random(-5,5))
        y.append(lerp(y1, y2, j/20.0)+random(-5,5))
    for k in range(20):
        x.append(lerp(x2, x3, k/20.0)+random(-5,5))
        y.append(lerp(y2, y3, k/20.0)+random(-5,5))
    x.append(x3)
    y.append(y3)
    
    for l in range(len(x)-1):
        line(x[l],y[l],x[l+1],y[l+1])
    
    pop()
   
def displayGraph():
    global total, freq
    for i in range(len(total)):
        if(i==ant.selected_edge):
            total[i].append(total[i][-1] + 1)
        else:
            total[i].append(total[i][-1])

    rat_0 = total[0][-1]/(len(total[0])-1.0) 
    rat_1 = total[1][-1]/(len(total[0])-1.0)
    rat_2 = total[2][-1]/(len(total[0])-1.0)
    rat_3 = total[3][-1]/(len(total[0])-1.0)
       
    freq[0].append(rat_0)
    freq[1].append(rat_0+rat_1)
    freq[2].append(rat_0+rat_1+rat_2)
    freq[3].append(rat_0+rat_1+rat_2+rat_3)
    
    push()
    translate(pathWidth+10, 10)
    
    fill(250)
    noStroke()
    rect(0, 0, graphWidth,graphHeight)
    
    strokeWeight(1)
    stroke(255)

    fill(30, 30, 30)
    beginShape()
    vertex(0,0)
    vertex(0,graphHeight*freq[3][0])
    for j in range(len(freq[3])):
        vertex((j+1)*graphWidth/len(freq[3]), graphHeight*freq[3][j])
    vertex(graphWidth, 0)
    endShape()
    
    fill(0, 0, 100)
    beginShape()
    vertex(0,0)
    vertex(0,graphHeight*freq[2][0])
    for j in range(len(freq[2])):
        vertex((j+1)*graphWidth/len(freq[2]), graphHeight*freq[2][j])
    vertex(graphWidth, 0)
    endShape()
    
    fill(0, 100, 0)
    beginShape()
    vertex(0,0)
    vertex(0,graphHeight*freq[1][0])
    for j in range(len(freq[1])):
        vertex((j+1)*graphWidth/len(freq[1]), graphHeight*freq[1][j])
    vertex(graphWidth, 0)
    endShape()

    fill(100, 0, 0)
    beginShape()
    vertex(0,0)
    vertex(0,graphHeight*freq[0][0])
    for j in range(len(freq[0])):
        vertex((j+1)*graphWidth/len(freq[0]), graphHeight*freq[0][j])
    vertex(graphWidth, 0)
    endShape()
    
    pop()
    
    
    println(freq)
    
    pass
                
class Ant:
    def __init__(self):
        self.initiate()
        
    def initiate(self):
        self.pos = 'start'
        self.selected_edge = -1
        self.delta_tau = [0,0,0,0]
        
    def activate(self):
        if(self.pos=='start'):
            self.selected_edge = self.choosePath()
            #println(self.selected_edge)
            self.pos = 'goal'
        
    def deposit(self):
        cdist = DIST_VAL[self.selected_edge]
        self.delta_tau[self.selected_edge] = 1.0/cdist
        return self.delta_tau
    
    def choosePath(self): # using roulette algorithm
        tau = []        # pheromone val
        eta = []        # heuristic val
        a   = []        # decesion pool
        pool = []       # decesion pool
        denom = 0
        
        # make decesion table
        for i in range(len(PHEROM_VAL)):
            tau.append(PHEROM_VAL[i])
            eta.append(1.0/DIST_VAL[i])
            denom+=pow(tau[i],ALPH)*pow(eta[i],BETA)
        for i in range(len(PHEROM_VAL)):
            a.append(pow(tau[i],ALPH)*pow(eta[i],BETA)/denom)
        
        # make decesion pool
        for i in range(len(PHEROM_VAL)):
            num = floor(a[i]*100)
            for n in range(num):
                pool.append(i)
        
        # choose randomely
        chosenPath = int(round(random(0, len(pool)-1)))
        #string = "{0}, {1}, {2}, {3}".format(a[0],a[1],a[2],a[3])
        #println(string)
        #println(pool)
        return pool[chosenPath]
    
    
def keyPressed():
    noLoop()
    
    
    
