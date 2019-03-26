public class Graph {

  private ArrayList<Vertex> graph;
  private int points;
  private Vertex[][] matrix;
  
  public Graph(int points) {
    this.graph = new ArrayList<Vertex>();
    this.points = points;
  }

  public void generateGraph() {
    int n = 0;
    int scale = (int) width/round(sqrt(points) + 2);
    int offset = round(scale / 2);
    // Generate coordinates 
    for (int i = offset; i < width; i += scale) {
      for(int j = scale; j < height; j += scale) {
          if(n < points) {
            if(j % (2*scale) == 0) {
              graph.add(new Vertex(n,i+(scale/2),j));
            } else {
              graph.add(new Vertex(n,i,j));
            }
          n++;
        }
      }
    }
    
    // Find number of rows and columns
    // Graph must have min. 3 nodes
    float prev = graph.get(0)
                      .location
                      .y;
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
  
  private void assignEdges(int columns, int rows) {
    for(int i = 0; i < columns-1; i++ ) {
      for(int j = 0; j < rows; j++) {
        Vertex v = matrix[i][j];
        int rand1, rand2, rand3 = 0;
        
        // Generate 3 different random numbers
        do {
          rand1 = (int) random(30,110);
          rand2 =  (int) random(30,110);
          rand3 = (int) random(30,110);
        } while(rand1 == rand2 || rand2 == rand3);
        
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
  
  public void display() {
    background(200);
    try {
      for(Vertex v: graph) {
        v.displayEdges();
      }
      for(Vertex v: graph) {
        v.displayVertex();
      }
      TimeUnit.MILLISECONDS.sleep(300);
    } catch (InterruptedException e) {
      println("InterruptedException at graph.display()");
    }
  }
  
  public ArrayList<Vertex> getVerticies() {
    return this.graph;
  }
  
}
