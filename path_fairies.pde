Fairy[] fairies = new Fairy[500];
int fairyCount = 0;
int maxFairies = 200;
static int width = 800;
static int height = 600;

void setup() {
  size(800, 600);
  colorMode(HSB, 100);
    fill(30, 20, 60, 100);
  rect(0, 0, width, height);
}


void draw() {
  
  noStroke();
  fill(30, 20, 60, 5);
  rect(0, 0, width, height);
  
  
  // draw every fairy
  for (Fairy f : fairies) {
    if (f == null) continue;
    
    f.synch(fairies);
    f.update();
  }
}

void mouseReleased() {
  createNewFairy(mouseX, mouseY);
}

void createNewFairy(int x, int y) {
  
  if (fairyCount > maxFairies) return;
  
  Fairy newFairy = new Fairy(new Vector2(x, y), 1);
  // add the new fairy to the array
  fairies[fairyCount] = newFairy;
  fairyCount++;
}
