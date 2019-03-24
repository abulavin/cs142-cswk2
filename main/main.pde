import java.util.Set;

ArrayList<Vertex> graph;
ArrayList<PVector> coords;
int points = 100;
int n = 0;
int scale;

void setup() {
  size(800,600);
  
  scale = (int) width/round(sqrt(points) + 2);
  int offset = round(scale / 2);
  
  graph = new ArrayList<Vertex>();
  coords = new ArrayList<PVector>();
  
  // Generate coordinates 
  for (int i = offset; i < width; i += scale) {
    for(int j = scale; j <= height-offset; j += scale) {
      if(j % (2*scale) == 0) {
        graph.add(new Vertex(i+(scale/2),j));
      } else {
        graph.add(new Vertex(i,j));
      }
    }
  }
    
  //for(int i = 0; i < points; i ++) {
  //  int code = 65+i;
  //  char label = (char) code;
  //  Vertex v = new Vertex(label);
  //  v.setLocation(coords.get(i).x,coords.get(i).y);
  //  graph.add(v);
  //}

}

Vertex chooseRandom() {
  int rand = (int) random(0,graph.size()-1);
  return graph.get(rand);
}
void draw() {
    background(200);
    //  //draw the grid
    // fill(255);
    //for (int i = 0; i < 600; i += 30){
    //    for(int j = 0; j < 600; j += 30){
    //    if(j % 60 == 0){//every other row
    //    ellipse(i+15,j,10,10);
    //    }else{
    //      ellipse(i,j,10,10);
    //        }
    //    }
    //}
    fill(255);
    for(PVector c : coords) {
      ellipse(c.x,c.y,5,5);
    } 
    for(Vertex v: graph) {
      v.display();
    }
}
