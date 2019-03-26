import java.util.concurrent.TimeUnit;
import java.util.Stack;
import controlP5.*;

Graph graph;
int[] dist;
ArrayList<Vertex> verticies;
Vertex[] prev;
ControlP5 cp5;
boolean animationComplete;

void setup() {
  size(800,600);
  frameRate(60);
  cp5 = new ControlP5(this);
  graph = new Graph(20);
  graph.generateGraph();
  
  animationComplete = false;
 verticies = new ArrayList<Vertex>();
 // Copy across graph verticies to new 'set'
 verticies.addAll(graph.getVerticies());
 prev = new Vertex[verticies.size()];
 dist = new int[verticies.size()];
 dist[0] = 0;
 
 for(int i = 1; i < dist.length; i++) {
   dist[i] = Integer.MAX_VALUE;
 }
 background(200);
 graph.display(false);
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
     graph.display(true);
     
     verticies.remove(u);
     
     for(Edge e : u.getAdjacent()) {
       Vertex v = e.getDest();
       e.markEdge(u);
       graph.display(true);
       
       int newDist = dist[u.index()] + e.weight();
       if( newDist < dist[v.index()]) {
         dist[v.index()] = newDist;
         
         prev[v.index()] = u; 
       }
     }
     u.mark(State.VISITED);
   } else {
     animationComplete = true;
     graph.display(false);
   }
  }
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
  graph.display(false);
  
  // cant draw from source or while animation still running
  if(!(v == 0 || !animationComplete)) {
    Vertex dest = graph.get(v); //<>//
    
    Stack<Vertex> path = djikstra(v); //<>//
    Vertex current = path.pop(); //<>//
    stroke(#02BBCE); // light blue

    while(!path.isEmpty()) { //<>//
      Vertex next = path.pop(); //<>//
      strokeWeight(2); //<>//
      line(current.location.x,current.location.y,next.location.x,next.location.y); //<>//
      current.highlight();
      current = next; //<>//
    } //<>//
    strokeWeight(2);
    line(current.location.x,current.location.y,dest.location.x,dest.location.y); //<>//
    current.highlight();
    dest.highlight();
  }
} //<>//
