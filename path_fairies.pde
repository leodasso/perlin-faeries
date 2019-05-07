

Fairy[] fairies = new Fairy[500];
int fairyCount = 0;
int maxFairies = 200;
static float timeElapsed = 0;
static float globalSine = 0;
static float synchDistance = 160;          // fairies can sync with each other, and will adjust to have the same angle.

void setup() {
  size(800, 600);
  colorMode(HSB, 100);
  rect(0, 0, width, height);
  
  for (int j = 0; j < 10; j++)
    createNewFairy(random(0, width), random(0, height));
}


void draw() {
  
  noStroke();
  fill(30, 60, 10);
  rect(0, 0, width, height);
  
  
  // draw every fairy
  for (Fairy f : fairies) {
    if (f == null) continue;

    f.update(fairies);
  }
  
  timeElapsed += .01;
  globalSine = sin(timeElapsed) + 1;
}

void mouseReleased() {
  
  for (int i = 0; i < 15; i++) {
  createNewFairy(mouseX + random(-30, 30), mouseY + random(-30, 30));
  }
}

void createNewFairy(float x, float y) {
  
  if (fairyCount > maxFairies) return;
  
  Fairy newFairy = new Fairy(new Vector2(x, y));
  // add the new fairy to the array
  fairies[fairyCount] = newFairy;
  fairyCount++;
}

static Vector2 VectorFromAngle(float eulerAngle) {
  
    float radians = radians(eulerAngle);
    return new Vector2(sin(radians), cos(radians));
}
