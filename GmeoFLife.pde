//Processing Code
void setup() {
  size(480*2, 480*2);
  background(0);
  //gof.shuffle();
}

boolean in(int num, int[] nums) {
  for(int i = 0; i < nums.length; i++){
    if (nums[i] == num) {
      return true;
    }
  }
  return false;
}

long counter = 0;
int frame = 5;
int sizemap = 64*3;
boolean play = true;
boolean autoplay = false;

//B35678/S5678
//B4678/S35678
//B3/S012345678
GameOfLife gof = new GameOfLife(sizemap, new int[] {2, 3}, new int[] {3});
void draw() {
  background(0);
  gof.drawMap();
  counter++;
  if (play && (mousePressed || autoplay)) {
    if (mouseButton == RIGHT) {
      println("False");
      play = false;
      delay(250);
      return;
    }
    if (counter % frame == 0) {
      gof.iter();
    }
    
  } else if (mousePressed && !play) {
    if (mouseButton == RIGHT) {
      println("True");
      play = true;
      delay(250);
      return;
    }
    int cellSize = width / gof.mapSize;
    int cellX = mouseX / cellSize;
    int cellY = mouseY / cellSize;
    println("Cell Number: ", cellX, cellY);
    gof.setCell(cellX, cellY);
    delay(100);
  }
}

void keyPressed() {
  if (key == 'S' || key == 's') {
    gof.shuffle();
  }
  if (key == 'C' || key == 'c') {
    gof.clearMap();
  }
  if (key == '+') {
    frame += 5;
    println("Frame: ", frame);
  }
  if (key == '-' && frame - 5 != 0) {
    frame -= 5;
    println("Frame: ", frame);
  }
  if (key == ' ') {
    autoplay = !autoplay;
    println("Autoplay:", autoplay);
  }
  if (key == '0') {
    gof.setCell(sizemap/2, sizemap/2);
  }
}
