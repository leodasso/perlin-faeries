
class Fairy {
  
  Fairy(Vector2 startPos, float startVel, float startAngle) {
    
    pos           = startPos;
    forwardVel    = startVel;
    angle         = startAngle;
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
    float debugLineSize = 50;
    float x = sin(radians) * debugLineSize;
    float y = cos(radians) * debugLineSize;
    
    // draw a debug line of the calculate angle vector
    line(pos.x, pos.y, pos.x + x, pos.y + y);
    
    // calculate distance travelled, add to distTravelled
    
    // calculate new angle based on perlin noise
    
    // display properties
    fill(0);
    textSize(10);
    text("angle:" + angle, pos.x + size, pos.y); 
    
 
    fill(0, 0, 255);
    ellipse(pos.x, pos.y, size, size);
  }
}
