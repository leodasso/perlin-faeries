Fairy[] fairies = new Fairy[500];
int fairyCount = 0;
int maxFairies = 200;

void setup() {
  size(800, 600);
  colorMode(HSB, 100);
  rect(0, 0, width, height);
}


void draw() {
  
  noStroke();
  fill(30, 60, 80);
  rect(0, 0, width, height);
  
  
  // draw every fairy
  for (Fairy f : fairies) {
    if (f == null) continue;

    f.update(fairies);
  }
}

void mouseReleased() {
  createNewFairy(mouseX, mouseY);
}

void createNewFairy(int x, int y) {
  
  if (fairyCount > maxFairies) return;
  
  Fairy newFairy = new Fairy(new Vector2(x, y), random(.5, 2));
  // add the new fairy to the array
  fairies[fairyCount] = newFairy;
  fairyCount++;
}

static Vector2 VectorFromAngle(float eulerAngle) {
  
    float radians = radians(eulerAngle);
    return new Vector2(sin(radians), cos(radians));
}
