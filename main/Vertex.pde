public class Vertex {
  
  private ArrayList<Edge> edges;
  public PVector location; 
  private int n;
  
  public Vertex(int n,float x, float y) {
    this.edges = new ArrayList<Edge>();
    this.location = new PVector();
    this.location.x = x;
    this.location.y = y;
    this.n = n;
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
  
  public void addEdge(Vertex v, float weight) {
    if(!isAdjacent(v)) {
      Edge e = new Edge(v,weight);
      this.edges.add(e);
      v.addEdge(this,weight);
    }
  }
  
  public Vertex[] getAdjacent() {
    Vertex[] adj = new Vertex[edges.size()];
    for(int i =  0; i < adj.length; i++) {
      adj[i] = edges.get(i).getDest();
    }
    return adj;
  }
  
  public void display() {
    stroke(0);
    fill(0);
    for(Edge e: edges) {
      Vertex dest = e.getDest();
      line(location.x,location.y,dest.location.x,dest.location.y);
    }
    ellipse(location.x,location.y,10,10);
    text(n,location.x+7,location.y+7);
  }
}
