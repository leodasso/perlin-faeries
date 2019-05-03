Fairy[] fairies = new Fairy[500];
int fairyCount = 0;
int width = 600;
int hieght = 400;
float noiseScale = .025;
float crossNoise = 100;
int resolution = 5;

float xOffset = 0;
float yOffset = 0;


void setup() {
  size(600, 400);
  colorMode(HSB, 100);
  drawNoiseDiagram();
}

void keyPressed() {
 
  if (key == CODED) {
    
    if (keyCode == UP) {
     noiseScale *= 1.1;
     drawNoiseDiagram();
    }
    if (keyCode == DOWN) {
      noiseScale *= .9;
      drawNoiseDiagram();
    }
    
    if (keyCode == LEFT) {
      crossNoise *= .9;
      drawNoiseDiagram();
    }
    if (keyCode == RIGHT) {
      crossNoise *= 1.1;
      drawNoiseDiagram();
    }
  }
  
  if (key == 'a') {
    xOffset += 10;
    drawNoiseDiagram();
  }
  if (key == 'd') {
    xOffset -= 10;
    drawNoiseDiagram();
  }
  if (key == 'w') {
    yOffset += 10;
    drawNoiseDiagram();
  }
  if (key == 's') {
    yOffset -= 10;
    drawNoiseDiagram();
  }
}

void drawNoiseDiagram() {
  
  clear();
  
  noStroke();
  
  println("drawing noise at scale " + noiseScale);
  
  float minNoise = 1000;
  float maxNoise = 0;
  
  for (int x = 0; x < 600; x += resolution) {
    
    for (int y = 0; y < 400; y += resolution) {
      
      float xNoise = noise((x + xOffset) * noiseScale);
      
      if (xNoise < minNoise) minNoise = xNoise;
      if (xNoise > maxNoise) maxNoise = xNoise;
      //float yNoise = noise((pow(y, xNoise) + yOffset) * noiseScale);
      
      fill(xNoise *  255);
      ellipse(x, y, resolution, resolution);
    }
  }
  
  println("min: " + minNoise + " max: " + maxNoise);
}

void draw() {
  
  //noStroke();
  //fill(30, 200, 200, 1);
  ////rect(0, 0, width, height);
  
  
  //// draw every fairy
  //for (Fairy f : fairies) {
  //  if (f == null) continue;
    
  //  f.update();
  //}
  
  //float hue = noise(mouseX * noiseScale) * 255;
  
  //color mouseColor = color(hue, 120, 120);
  //fill(mouseColor);
  
  //println(hue);
  
  //ellipse(mouseX, mouseY, 10, 10);
}

void mouseReleased() {
  createNewFairy(mouseX, mouseY);
}

void createNewFairy(int x, int y) {
  
  print("creating a new fairy");
  
  Fairy newFairy = new Fairy(new Vector2(mouseX, mouseY));
  
  // add the new fairy to the array
  fairies[fairyCount] = newFairy;
  fairyCount++;
}
