/** //<>// //<>//
 * Class that encapsulates verticies and graph generation
 * Repsonisble for drawing the graph with and without a delay
 */
public class Graph {

  private ArrayList<Vertex> graph;
  private int points;
  private Vertex[][] matrix;

  /**
   * Create a new graph
   * @param points Number of vertices
   * @return       new graph with points vertices
   */
  public Graph(int points) {
    this.graph = new ArrayList<Vertex>();
    this.points = points;
  }

  /**
   * Generate a new graph by creating Vertex objects, buttons
   * and adding edges to vertices
   */
  public void generateGraph() {
    int n = 0; // counter

    // Make sure spacing between nodes is scaled to fit screen
    int scale = (int) (width)/round(sqrt(points) + 2);
    int offset = round(scale / 2);

    // Generate isometric coordinates
    for (int i = offset; i < width; i += scale) {
      for(int j = scale; j < height; j += scale) {
          if(n < points) {
            if(j % (2*scale) == 0) {
              Vertex v = new Vertex(n,i+(scale/2),j);
              graph.add(v);
              createButton(v.toString(),n,i+(scale/2),j);
            } else {
              Vertex v = new Vertex(n,i,j);
              graph.add(v);
              createButton(v.toString(),n,i,j);
            }
          n++;
        }
      }
    }

    // Find number of rows and columns
    // Graph must have min. 3 nodes
    float prev = graph.get(0).location.y;
    int rows = 1;
    for(int i = 1; i < graph.size(); i++) {
      if (graph.get(i).location.y  <= prev) {
        rows = i;
        break;
      }
    }
    int columns = (int) ceil((float) this.points/rows);

    // Construct graph matrix
    this.matrix = new Vertex[columns][rows];
    int k = 0;
    for(int i = 0; i < columns; i++ ) {
      for(int j = 0; j < rows; j++) {
        if(k < graph.size())
          matrix[i][j] = graph.get(k++);
      }
    }
    assignEdges(columns,rows);
  }

  /**
   * Creates a new button from the ControlP5 class for a vertex
   * @param name Display name of the button
   * @param val  Index of the Vertex
   * @param x    x coordinate of button position
   * @param y    y coordinate of button position
   */
  public void createButton(String name,int val, int x , int y) {
    cp5.addButton(name)
       .setValue(val)
       .setPosition(x, y)
       .setSize(15, 15)
       .onPress(new CallbackListener() {
         // WHen pressed, button will cause path from source to this vertex to be drawn
         public void controlEvent(CallbackEvent theEvent) {
           drawPath((int) theEvent.getController().getValue());
         }
       });
  }

  /**
   * Assign Edges to vertices so that edges are of equal visual length
   * @param columns Number of columns in the graph
   * @param rows    Number of rows in the graph
   */
  private void assignEdges(int columns, int rows) {
    // For each vertex in the matrix
    for(int i = 0; i < columns-1; i++ ) {
      for(int j = 0; j < rows; j++) {
        Vertex v = matrix[i][j];
        // Generate 3 different random numbers
        int rand1, rand2, rand3 = 0;

        do {
          rand1 = (int) random(30,110);
          rand2 =  (int) random(30,110);
          rand3 = (int) random(30,110);
        } while(rand1 == rand2 || rand2 == rand3);

        // Join edges based on the position of the node
        if(j == 0) {
          v.addEdge(matrix[i][j+1],rand1);
          v.addEdge(matrix[i+1][j],rand2);
        } else if (j == rows-1) {
          if(j % 2 == 0) {
            v.addEdge(matrix[i][j-1],rand1);
            v.addEdge(matrix[i+1][j],rand2);
          } else {
            v.addEdge(matrix[i+1][j-1],rand1);
            v.addEdge(matrix[i+1][j],rand2);
          }
        } else {
          if(j % 2 == 0) {
            v.addEdge(matrix[i][j-1],rand1);
            v.addEdge(matrix[i+1][j],rand2);
            v.addEdge(matrix[i][j+1],rand3);
          } else {
            v.addEdge(matrix[i+1][j-1],rand1);
            v.addEdge(matrix[i+1][j],rand2);
            v.addEdge(matrix[i+1][j+1],rand3);
          }
        }
      }
    }
  }

  /**
   * Draw the graph with a 300 millisecond delay
   */
  public void displayWithDelay() {
    background(200);
      try {
        display();
        TimeUnit.MILLISECONDS.sleep(300);
      } catch (InterruptedException e) {
        println("InterruptedException at graph.display()");
      }
  }

  /**
   * Draw the graph without a delay
   */
  public void display() {
    background(200);
    for(Vertex v: graph) {
      v.displayEdges();
     }
     for(Vertex v: graph) {
      v.displayVertex();
     }
    drawTitle();
  }

  /**
   * Return a vertex from the graph with index i
   * @param  i Index of vertex
   * @return   Vertex with index i
   */
  public Vertex get(int i) {
    return this.graph.get(i);
  }

  /**
   * Returns the size of the graph i.e the number of vertices
   * @return [description]
   */
  public int size() {
    return this.graph.size();
  }

  /**
   * Return an ArrayList of all vertices
   * @return [description]
   */
  public ArrayList<Vertex> getVerticies() {
    return this.graph;
  }

  /**
   * Set the tentative distance for a vertex
   * @param index Index of vertex
   * @param dist  Tentative distance
   */
  public void setDist(int index, int dist) {
    this.graph.get(index).dist = dist;
  }
}
