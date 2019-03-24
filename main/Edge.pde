public class Edge {

  private float weight;
  private Vertex dest;
  
  Edge(Vertex dest, float weight) {
    this.dest = dest;
    this.weight = weight;
  }

  public Vertex getDest() {
    return this.dest;
  }
  
  public float weight() {
    return this.weight;
  }
}
