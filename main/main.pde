import java.util.Set;

HashMap<Character,Vertex> graph;
Character[] verticies;


void setup() {
  size(800,600);
  graph = new HashMap<Character,Vertex>();
  for(int i = 0; i < 10; i ++) {
    int code = 65+i;
    char label = (char) code ;
    graph.put(label,new Vertex(label));
  }
  verticies = graph.keySet().toArray(new Character[0]);
  
  for(Character v : verticies) {
    graph.get(v).setLocation(random(0,width-10), random(0, height-10));
    graph.get(v).addEdge(graph.get(chooseRandom()), random(0,10));
  }
  
}

Character chooseRandom() {
  int rand = (int) random(0,verticies.length-1);
  return verticies[rand];
}

void draw() {
  background(255);
  
  for(Character c : graph.keySet()) {
    graph.get(c).display();
    println(c);

  }
  noLoop();
}
