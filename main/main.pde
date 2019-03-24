import java.util.Set;

ArrayList<Vertex> graph;
int points = 10;
int n = 0;
int scale;

void setup() {
  size(800,600);
  
  scale = (int) width/round(sqrt(points) + 2);
  int offset = round(scale / 2);
  
  graph = new ArrayList<Vertex>();
  
  // Generate coordinates 
  for (int i = offset; i < width; i += scale) {
    for(int j = scale; j < height; j += scale) {
        if(n < points) {
          if(j % (2*scale) == 0) {
            graph.add(new Vertex(n,i+(scale/2),j));
          } else {
            graph.add(new Vertex(n,i,j));
          }
        n++;
      }
    }
  }
  for(Vertex v: graph) {
    int rand = (int) random(2,3);
    for(int i = 1; i <= rand; i ++) {
      int index = graph.indexOf(v);
      Vertex randVertex = graph.get(constrain((int) random(2*index,2*index+2), 0, graph.size()-1));
      
      while(randVertex == null) {
        randVertex = graph.get((int)random(index,index+2));
      }
      v.addEdge(randVertex,100);
    }
  }
  println(graph.size());
}

Vertex chooseRandom() {
  int rand = (int) random(0,graph.size()-1);
  return graph.get(rand);
}
void draw() {
    background(200);
    for(Vertex v: graph) {
      v.display();
    }
}
