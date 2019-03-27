/**
 * Class to represent an edge in the graph.
 *
 */

public class Edge {

  private int weight;
  private Vertex dest;
  private color colour;

  /**
   * Creates a new edge
   * @param dest   Destination of the edge/end vertex
   * @param weight Weight of the edge
   * @return       Edge object
   */
  Edge(Vertex dest, int weight) {
    this.dest = dest;
    this.weight = weight;
    this.colour = #000000;
  }

  /**
   * Mark an edge as visited
   * @param v Source vertex of the edge
   */
  public void markEdge(Vertex v) {
    // Mark both vertexes from v to dest and from dest to v
    for(Edge e: this.dest.getAdjacent()) {
      if(e.getDest().equals(v)) {
        e.markEdge();
      }
    }
  }

  /**
   * Change the colour of the edge to mark it as visited
   */
  private void markEdge() {
    this.colour = #33B409; //green
  }

  /**
   * Get the colour of the edge
   * @return Black by default, green if visitsed
   */
  public color getColour() {
    return this.colour;
  }

  /**
   * Get the destination/end point of this edge
   * @return Destination vertex
   */
  public Vertex getDest() {
    return this.dest;
  }

  /**
   * Get the weight of the edge
   * @return Weight of the edge
   */
  public int weight() {
    return this.weight;
  }
}
