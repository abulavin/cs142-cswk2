public class Vertex {
  
  private ArrayList<Edge> edges;
  public PVector location; 
  private int n;
  public State visited;
  private String label;
  public int dist;
  
  public Vertex(int n,float x, float y) {
    this.edges = new ArrayList<Edge>();
    this.location = new PVector();
    this.location.x = x;
    this.location.y = y;
    this.n = n;
    this.label = Character.toString(((char) (65+n)));
    this.visited = State.UNVISITED;
  }
  
  public boolean isAdjacent(Vertex v) {
    for(Edge e : edges) {
      if(e.getDest().equals(v)) {
        return true;
      }
    }
    return false;
  }
  
  public void setLocation(float x, float y) {
    this.location.x = x;
    this.location.y = y;
  }
  
  public void addEdge(Vertex v, int weight) {
    if(v != null) {
      if(!isAdjacent(v)) {
        Edge e = new Edge(v,weight);
        this.edges.add(e);
        v.addEdge(this,weight);
      }
    }
}
  
  public Edge[] getAdjacent() {
    Edge[] adj = new Edge[edges.size()];
    for(int i =  0; i < adj.length; i++) {
      adj[i] = edges.get(i);
    }
    return adj;
  }
  
  public int index() {
    return this.n;
  }
  
  public void displayEdges() {
    stroke(0);
    strokeWeight(1);
    for(Edge e: edges) {
      Vertex dest = e.getDest();
      stroke(e.getColour());
      line(this.location.x,this.location.y,dest.location.x,dest.location.y);
      
      // Text label
      PVector label = PVector.sub(dest.location,this.location)
                             .mult(0.5)
                             .add(this.location);
      String weight = e.weight() + "";
      textSize(10);
      textAlign(CORNER);
      fill(0);
      text(weight,label.x,label.y);
    }
  }
  
  public void displayVertex() {
    switch(this.visited) {
      case UNVISITED: fill(#D30F0F);
                      break;
      case CURRENT: fill(#D88327);
                    break;
      case VISITED: fill(#33B409);
                    break;
    }
    stroke(0);
    ellipse(location.x,location.y,10,10);
    textAlign(CENTER,BOTTOM);
    textSize(24);
    text(this.label,location.x,location.y-5);
  }
  
  public void mark(State s) {
    this.visited = s;
  }
  
  public String toString() {
    return this.label;
  }
  
  public void highlight() {
    fill(#02BBCE);
    strokeWeight(1);
    ellipse(location.x,location.y,10,10);
    textAlign(CENTER,BOTTOM);
    textSize(24);
    text(this.label,location.x,location.y-5);
  }
}
