Fairy[] fairies = new Fairy[500];
int fairyCount = 0;
int width = 600;
int hieght = 400;
float noiseScale = .025;
int resolution = 5;

float xOffset = 0;
float yOffset = 0;


void setup() {
  size(600, 400);
  colorMode(HSB, 100);
}


void draw() {
  
  noStroke();
  fill(30, 200, 200, 1);
  //rect(0, 0, width, height);
  
  
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
  
  Fairy newFairy = new Fairy(new Vector2(mouseX, mouseY), 5, 90);
  
  // add the new fairy to the array
  fairies[fairyCount] = newFairy;
  fairyCount++;
}
