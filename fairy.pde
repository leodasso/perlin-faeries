
class Fairy {
  
  boolean debug = false;
  Vector2 pos;
  float forwardVel = 0;
  float angle = 0;
  float size = 5;
  float distTravelled = 0;
  float distOffset = 0;
  float erraticness = .01;
  float turnPower = 20;
  float synchDistance = 100;          // fairies can sync with each other, and will adjust to have the same angle.
  float synchPower = 1;
  color myColor = color(0, 10, 255);
  color defaultColor = color(0, 10, 255);
  
  
  Fairy(Vector2 startPos, float startVel) {
    
    pos           = startPos;
    forwardVel    = startVel;
    angle         = random(0, 360);
    distOffset   = random(-100, 100);
    
    println("new fairy dist offset " + distOffset);
  }
  

  void update() {
    
    //move the fairy forward at the current angle
    float radians = radians(angle);
    
    float x = sin(radians);
    float y = cos(radians);
    
    // calculate distance travelled, add to distTravelled
    distTravelled += forwardVel;
    
    // calculate new angle
    float deltaAngle = noise((distTravelled + distOffset)* erraticness) - .5;
    deltaAngle *= turnPower;
    angle += deltaAngle;
    if (angle >= 360) angle -= 360;
    if (angle <= 0) angle += 360;
    
    boundaryBounce();
    
    if (debug) drawDebugInfo();
    
    pos.sumWith(new Vector2(x * forwardVel, y * forwardVel));
 
    fill(myColor);
    ellipse(pos.x, pos.y, size, size);
  }
  
  void boundaryBounce() {
    if (pos.x < 0
  }
  
  
  
  void synch(Fairy[] allFairies) {
    
    myColor = defaultColor;
    
    for (Fairy other : allFairies) {
      
      if (other == this) continue;
      if (other == null) continue;
      
      float distToFairy = dist(other.pos.x, other.pos.y, pos.x, pos.y);
      if ( distToFairy > synchDistance) continue;
        
      // get the degree of influence based on how close they are
      float influence = (synchDistance - distToFairy)/synchDistance;
      
      stroke(255, 0, 255, 100 * influence);
      line(pos.x, pos.y, other.pos.x, other.pos.y);
      
      myColor = color(160, 255, 255);
      
    }
  }
  
  
  
  void drawDebugDirection(float x, float y) {
    stroke(0);
    float debugLineSize = 50;
    line(pos.x, pos.y, pos.x + x * debugLineSize, pos.y + y * debugLineSize);
  }
  
  void drawDebugInfo() {
    // display properties
    fill(0);
    textSize(10);
    text("angle:" + angle, pos.x + size, pos.y); 
  }
}
