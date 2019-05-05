Fairy[] fairies = new Fairy[500];
int fairyCount = 0;
int width = 800;
int hieght = 600;

void setup() {
  size(800, 600);
  colorMode(HSB, 100);
}


void draw() {
  
  clear();
  
  noStroke();
  fill(30, 200, 200, 100);
  rect(0, 0, width, height);
  
  
  // draw every fairy
  for (Fairy f : fairies) {
    if (f == null) continue;
    
    f.update();
  }
}

void mouseReleased() {
  createNewFairy(mouseX, mouseY);
}

void createNewFairy(int x, int y) {
  
  print("creating a new fairy");
  
  Fairy newFairy = new Fairy(new Vector2(x, y), 1, 90);
  
  // add the new fairy to the array
  fairies[fairyCount] = newFairy;
  fairyCount++;
}
