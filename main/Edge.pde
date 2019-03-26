public class Edge {

  private int weight;
  private Vertex dest;
  private color colour;
  
  Edge(Vertex dest, int weight) {
    this.dest = dest;
    this.weight = weight;
    this.colour = #000000;
  }
  
  public void displayEdge() {
    
  }

  public void markEdge(Vertex v) {
    this.colour = #D30F0F;
    for(Edge e: this.dest.getAdjacent()) {
      if(e.getDest().equals(v)) {
        e.markEdge();
      }
    }
  }
  
  public void markEdge() {
    this.colour = #D30F0F; //red
  }
  
  public color getColour() {
    return this.colour;
  }
  
  public Vertex getDest() {
    return this.dest;
  }
  
  public int weight() {
    return this.weight;
  }
}
