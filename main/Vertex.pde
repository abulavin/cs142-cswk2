/**
 * Class that represents a node/vertex in the graph
 * Vertices have a Letter label e.g A,B,C as well as a unique
 * integer "index"
 */
public class Vertex {

  public PVector location;
  public State visited;
  public int dist;
  private int n;
  private ArrayList<Edge> edges;
  private String label;

  /**
   * Cretaes a new vertex
   * @param n Index or number of vertex
   * @param x x coordinate of position
   * @param y y coordinate of position
   */
  public Vertex(int n, float x, float y) {
    this.edges = new ArrayList<Edge>();
    this.location = new PVector();
    this.location.x = x;
    this.location.y = y;
    this.n = n;
    this.label = Character.toString(((char) (65+n)));
    this.visited = State.UNVISITED;
  }

  /**
   * Checks if there is an edge between this vertex and Vertex v
   * @param  v Vertex
   * @return   True if an edge exists between this vertex and x, false otherwise
   */
  public boolean isAdjacent(Vertex v) {
    for (Edge e : edges) {
      if (e.getDest().equals(v)) {
        return true;
      }
    }
    return false;
  }

  /**
   * Add an edge to a vertex.
   * Since edges only store destination, an edge is also added for the
   * destination vertex that points to this vertex
   * @param v      Destination vertex
   * @param weight Weight of edge
   */
  public void addEdge(Vertex v, int weight) {
    // Sanity check
    if (v != null) {
      //If an edge already exists dont add a new one
      if (!isAdjacent(v)) {
        Edge e = new Edge(v, weight);
        this.edges.add(e);
        v.addEdge(this, weight);
      }
    }
  }

  /**
   * Get all Adjacent adges
   * @return An array of edges adjacent at this vertex
   */
  public Edge[] getAdjacent() {
    Edge[] adj = new Edge[edges.size()];
    for (int i =  0; i < adj.length; i++) {
      adj[i] = edges.get(i);
    }
    return adj;
  }

  /**
   * Return the index of this vertex
   * @return index
   */
  public int index() {
    return this.n;
  }

  /**
   * Display/draw the edges belonging to this vertex
   */
  public void displayEdges() {
    stroke(0);
    strokeWeight(1);
    for (Edge e : edges) {
      Vertex dest = e.getDest();
      stroke(e.getColour());
      line(this.location.x, this.location.y, dest.location.x, dest.location.y);

      // Text label - calculate position of label
      PVector label = PVector.sub(dest.location, this.location)
                             .mult(0.5)
                             .add(this.location);
      String weight = e.weight() + "";
      textSize(12);
      textAlign(CORNER);
      fill(0);
      text(weight, label.x+2, label.y-2);
    }
  }

  /**
   * Display the vertex based on its current state,
   * as well as its current tentative distance
   */
  public void displayVertex() {
    switch(this.visited) {
      case UNVISITED:
        fill(#C313D1); // magenta
        break;
      case CURRENT:
        fill(#F0DE11); // dark blue
        break;
      case VISITED:
        fill(#33B409); // green
        break;
    }
    stroke(0);
    ellipse(location.x, location.y, 10, 10);
    textAlign(CENTER, BOTTOM);
    textSize(24);
    text(this.label, location.x, location.y-5);

    //Show tentative distance

    String dist;
    if (this.dist == Integer.MAX_VALUE) {
      dist = "inf"; // Infinity
    } else {
      dist = Integer.toString(this.dist);
    }
    fill(255);
    stroke(0);
    // Rectangle scales with text size
    rect(this.location.x+13, this.location.y-25, textWidth(dist)/1.5, 15);
    fill(0);
    textAlign(CORNER);
    textSize(14);
    text(dist, this.location.x+14, this.location.y-12);
  }

  /**
   * Change the state of this vertex
   * @param s new State
   */
  public void mark(State s) {
    this.visited = s;
  }

  /**
   * Returns a string representation of this vertex
   * @return [description]
   */
  public String toString() {
    return this.label;
  }

  /**
   * Highligh the vertex as cyan when displaying shortest path
   */
  public void highlight() {
    fill(#02BBCE);
    strokeWeight(1);
    ellipse(location.x, location.y, 10, 10);
    textAlign(CENTER, BOTTOM);
    textSize(24);
    text(this.label, location.x, location.y-5);
  }
}
