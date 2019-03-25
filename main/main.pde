Graph g;

void setup() {
  size(800,600);
  g = new Graph(20);
  g.generateGraph();
}

void draw() {
  background(200);
  g.display();  
}
