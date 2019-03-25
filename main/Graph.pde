public class Graph {

  private ArrayList<Vertex> graph;
  private int points;
  
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
    Vertex[][] matrix = new Vertex[columns][rows];
    int k = 0;
    for(int i = 0; i < columns; i++ ) {
      for(int j = 0; j < rows; j++) {
        if(k < graph.size())
          matrix[i][j] = graph.get(k++);
      }
    }

    // Assign edges
    for(int i = 0; i < columns-1; i++ ) {
      for(int j = 0; j < rows; j++) {
        if(j == 0) {
          matrix[i][j].addEdge(matrix[i][j+1],100);
          matrix[i][j].addEdge(matrix[i+1][j],100);
        } else if (j == rows-1) {
          matrix[i][j].addEdge(matrix[i+1][j-1],100);
          matrix[i][j].addEdge(matrix[i+1][j],100);
        } else {
          if(j % 2 == 0) {
            matrix[i][j].addEdge(matrix[i][j-1],100);
            matrix[i][j].addEdge(matrix[i+1][j],100);
            matrix[i][j].addEdge(matrix[i][j+1],100);
          } else {
            matrix[i][j].addEdge(matrix[i+1][j-1],100);
            matrix[i][j].addEdge(matrix[i+1][j],100);
            matrix[i][j].addEdge(matrix[i+1][j+1],100);      
          }
        }
      }
    }
    
    
  }
  
  public void display() {
    for(Vertex v: graph) {
      v.display();
    }
  }
}
