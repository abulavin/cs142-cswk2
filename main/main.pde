Graph graph;
int[] dist;
ArrayList<Vertex> verticies;
Vertex[] prev;

void setup() {
  size(800,600);
  frameRate(60);
  graph = new Graph(26);
  graph.generateGraph();
  
 verticies = new ArrayList<Vertex>();
 // Copy across graph verticies to new 'set' //<>//
 verticies.addAll(graph.getVerticies());
 prev = new Vertex[verticies.size()]; //<>//
 dist = new int[verticies.size()];
 dist[0] = 0;
 
 for(int i = 1; i < dist.length; i ++) {
   dist[i] = Integer.MAX_VALUE;
 }
}
 //<>//
void draw() {
  background(200); 
  graph.display();
  if(!verticies.isEmpty()) {
   // Find vertex u with min dist[u]
   int min = Integer.MAX_VALUE;
   for(int i = 0; i < dist.length; i++) {
     if(dist[i] < min) {
       min = i;
     }
   }
   Vertex u = verticies.get(min);
   verticies.remove(u);
   
   for(Edge e : u.getAdjacent()) {
     Vertex v = e.getDest();
     
     int newDist = dist[u.index()] + e.weight();
     if( newDist < dist[v.index()]) {
       dist[v.index()] = newDist;
       prev[v.index()] = u; 
     }
   }
 }
 
   // Print out distances //<>//
  ArrayList<Vertex> verticies = graph.getVerticies();
  for(Vertex v: verticies) {
    int i = v.index();
    print(v + ": ");
    while(prev[i] != null) {
      print(" -> " + prev[i]);
      i = prev[i].index();
    }
    println("");
  }
}
// 1  function Dijkstra(Graph, source):
// 2
// 3      create vertex set Q
// 4
// 5      for each vertex v in Graph:             
// 6          dist[v] ← INFINITY                  
// 7          prev[v] ← UNDEFINED                 
// 8          add v to Q                      
//10      dist[source] ← 0                        
//11      
//12      while Q is not empty:
//13          u ← vertex in Q with min dist[u]    
//14                                              
//15          remove u from Q 
//16          
//17          for each neighbor v of u:           
//18              alt ← dist[u] + length(u, v)
//19              if alt < dist[v]:               
//20                  dist[v] ← alt 
//21                  prev[v] ← u 
//22
//23      return dist[], prev[]
