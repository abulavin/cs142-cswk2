import java.util.concurrent.TimeUnit;
import java.util.Stack;
import controlP5.*;

Graph graph;
int[] dist;
int nodes;
int markedVertex;
ArrayList<Vertex> verticies;
Vertex[] prev;
ControlP5 cp5Main;
ControlP5 cp5;
boolean animationComplete;

void setup() {
  size(800,600);
  frameRate(120);
  nodes = 10;
  markedVertex = 0;
  cp5Main = new ControlP5(this);
  
  cp5Main.addButton("-")
     .setValue(0)
     .setPosition(width-60, 45)
     .setSize(15, 15)
     .onPress(new CallbackListener() {
         public void controlEvent(CallbackEvent theEvent) {
           if(nodes > 3) {
             nodes--;
             updateNodes();
           }
         }
     });
  cp5Main.addButton("+")
     .setValue(0)
     .setPosition(width-40, 45)
     .setSize(15, 15)
     .onPress(new CallbackListener() {
         public void controlEvent(CallbackEvent theEvent) {
           if(nodes < 26) {
             nodes++;
             updateNodes();
           }
         }
     });
  cp5Main.addButton("New Graph")
     .setValue(0)
     .setPosition(width -95, 70)
     .setSize(70,20)
     .onPress(new CallbackListener() {
         public void controlEvent(CallbackEvent theEvent) {
            cp5.dispose();
            djikstraSetup();
            draw();
         }
     });
 djikstraSetup();
}
void djikstraSetup() {
 graph = new Graph(nodes);
 cp5 = new ControlP5(this);
 graph.generateGraph();
 animationComplete = false;
 verticies = new ArrayList<Vertex>();
 // Copy across graph verticies to new 'set'
 verticies.addAll(graph.getVerticies());
 prev = new Vertex[verticies.size()];
 dist = new int[verticies.size()];
 dist[0] = 0;
 graph.setDist(0,0);
 
 for(int i = 1; i < dist.length; i++) {
   dist[i] = Integer.MAX_VALUE;
   graph.setDist(i,Integer.MAX_VALUE);
 }
 background(200);
 graph.display();
}


void draw() {
  if(!animationComplete) {
    if(!verticies.isEmpty()) {
     // Find vertex u with min dist[u]
     int min = Integer.MAX_VALUE;
     for(int i = 0; i < dist.length; i++) {
       if(dist[i] < min) {
         min = i;
       }
     }
     Vertex u = verticies.get(min);
     u.mark(State.CURRENT);
     graph.displayWithDelay();
     
     verticies.remove(u);
     
     for(Edge e : u.getAdjacent()) {
       Vertex v = e.getDest();
       e.markEdge(u);
       graph.displayWithDelay();
       
       int newDist = dist[u.index()] + e.weight();
       if( newDist < dist[v.index()]) {
         dist[v.index()] = newDist;
         graph.setDist(v.index(),newDist);
         prev[v.index()] = u; 
         graph.displayWithDelay();
       }
     }
     u.mark(State.VISITED);
   } else {
     animationComplete = true;
     drawPath(markedVertex);
     graph.display();
   }
  }
  updateNodes();
}

Stack<Vertex> djikstra(int vertexIndex) {
  // Build path from A with stack
  Stack<Vertex> jumps = new Stack<Vertex>();
    int i = vertexIndex; //<>//
    while(prev[i] != null) {
      jumps.push(prev[i]); //<>//
      i = prev[i].index(); //<>//
    }
  return jumps;
}

void drawPath(int v) {
  graph.display();
  
  // cant draw from source or while animation still running
  if(!(v == 0 || !animationComplete)) {
    Vertex dest = graph.get(v); //<>//
    
    Stack<Vertex> path = djikstra(v); //<>//
    Vertex current = path.pop(); //<>//
    stroke(#02BBCE); // light blue

    while(!path.isEmpty()) { //<>//
      Vertex next = path.pop(); //<>//
      strokeWeight(3); //<>//
      line(current.location.x,current.location.y,next.location.x,next.location.y); //<>//
      current.highlight();
      current = next; //<>//
    } //<>//
    strokeWeight(3);
    line(current.location.x,current.location.y,dest.location.x,dest.location.y); //<>//
    current.highlight();
    dest.highlight();
  }
} //<>//

void updateNodes() {
  textAlign(CORNER);
  fill(200);
  noStroke();
  rect(width-170,42,100,20);
  fill(0);
  textSize(20);
  text("Nodes: " + nodes,width-170,60);
}

void drawTitle() {
  textSize(28);
  fill(0);
  text("Dijkstra's Algorithm from A",20, 50);
}
