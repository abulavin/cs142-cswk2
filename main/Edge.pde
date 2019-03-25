public class Edge {

  private int weight;
  private Vertex dest;
  private color colour;
  
  Edge(Vertex dest, int weight) {
    this.dest = dest;
    this.weight = weight;
    this.colour = #000000;
  }

  public void markEdge() {
    this.colour = #D30F0F;
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
