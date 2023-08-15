class GameOfLife {
  int mapSize;
  int[] survive = new int[] {2, 3};
  int[] born = new int[] {3};
  int[][] map;
  
  GameOfLife(int size, int[] survive, int[] born) {
    this.mapSize = size;
    this.survive = survive;
    this.born = born;
    this.map = new int[this.mapSize][this.mapSize];
  }
  
  void drawMap() {
    int rectSize = width / this.mapSize;
    for(int i = 0; i < this.mapSize; i++) {
      for(int j = 0; j < this.mapSize; j++) {
        //print(this.map[i][j], " ");
        if (this.map[i][j] != 0) {
          square(rectSize * j, rectSize * i, rectSize);
        }
      }
    }
  }
  void clearMap() {
    for(int i = 0; i < this.mapSize; i++) {
      for(int j = 0; j < this.mapSize; j++) {
        this.map[i][j] = 0;
      }
    }
  }
  
  void shuffle() {
    for(int i = 0; i < this.mapSize; i++) {
      for(int j = 0; j < this.mapSize; j++) {
        this.map[i][j] = int(random(2));
      }
    }
  }
  
  int normalize(int num) {
    return (this.mapSize + num) % this.mapSize;
  }
  
  int nearest(int x, int y) {
    int count = 0;
    int normX, normY;
    for (int i = -1; i < 2; i++) {
      for (int j = -1; j < 2; j++) {
        if (i == 0 && j == 0) {
          continue;
        }
        normX = this.normalize(x+i);
        normY = this.normalize(y+j);
        
        count += this.map[normY][normX];
      }
    }
    return count;
  }
  
  void iter() {
    int[][] newMap = new int[this.mapSize][this.mapSize];
    int cellsCount;
    for(int i = 0; i < this.mapSize; i++) {
      for(int j = 0; j < this.mapSize; j++) {
        cellsCount = this.nearest(i, j);
        if (in(cellsCount, this.born) && this.map[j][i] != 1) {
          newMap[j][i] = 1;
          continue;
        } else if (in(cellsCount, this.survive) && this.map[j][i] == 1) {
          newMap[j][i] = 1;
          continue;
        } else {
          newMap[j][i] = 0;
        }
      }
    }
    this.map = newMap;
  }
  
  void setCell(int x, int y) {
    try{
      this.map[y][x] = (this.map[y][x] + 1) % 2;
    } catch (ArrayIndexOutOfBoundsException e) {
      println("Error Out of range");
    }
  }
  
  void updateMapSize(int newSize){
    int[][] newMap = new int[newSize][newSize];
    int difference = this.mapSize - newSize;
    
    if (newSize > this.mapSize) {
      /*
      for(int i = (newSize - this.mapSize) / 2; i < this.mapSize + (newSize - this.mapSize) / 2; i++) {
        for(int j = (newSize - this.mapSize) / 2; j < this.mapSize + (newSize - this.mapSize) / 2; j++) {
          newMap[]
        }
      }*/
      difference = newSize - this.mapSize;
      
      for(int i = 0; i < this.mapSize; i++) {
        for(int j = 0; j < this.mapSize; j++) {
          newMap[j+difference][j+difference] = this.map[i][j];
        }
      }
      this.mapSize = newSize;
      return;
    }
    
    
  }
}
