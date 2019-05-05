
class Fairy {
  
  boolean debug = false;
  
  Fairy(Vector2 startPos, float startVel, float startAngle) {
    
    pos           = startPos;
    forwardVel    = startVel;
    angle         = random(0, 360);
    noiseOffset   = random(0, 50);
  }
  
  Vector2 pos;
  float forwardVel = 0;
  float angle = 0;
  float size = 5;
  float distTravelled = 0;
  float noiseOffset = 0;
  
  void update() {
    
    //move the fairy forward at the current angle
    float radians = radians(angle);
    
    float x = sin(radians);
    float y = cos(radians);
    
    stroke(0);
    // draw a debug line of the calculate angle vector
    float debugLineSize = 50;
    line(pos.x, pos.y, pos.x + x * debugLineSize, pos.y + y * debugLineSize);
    
    // calculate distance travelled, add to distTravelled
    distTravelled += forwardVel;
    
    // calculate new angle
    angle++;
    if (angle >= 360) angle -= 360;
    if (angle <= 0) angle += 360;
    
    if (debug) drawDebugInfo();
    
    pos.sumWith(new Vector2(x * forwardVel, y * forwardVel));
 
    fill(0, 0, 255);
    ellipse(pos.x, pos.y, size, size);
  }
  
  void drawDebugInfo() {
    // display properties
    fill(0);
    textSize(10);
    text("angle:" + angle, pos.x + size, pos.y); 
  }
}
