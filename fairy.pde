
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
  color myColor;
  color defaultColor;
  color influenceColor;
  int bounceBuffer = 0;
  ArrayList<Vector2> trail = new ArrayList<Vector2>();
  int maxTrail = 50;
  int framesElapsed = 0;
  float myHue = 0;
  float totalInfluence = 0;
  
  
  Fairy(Vector2 startPos, float startVel) {
    
    pos = startPos;
    forwardVel = startVel;
    angle = random(0, 360);
    distOffset = random(-100, 100);
    size = random(5, 20);
    myHue = random(0, 100);
    defaultColor = color(myHue, 30, 200);
    influenceColor = color(myHue, 140, 255);
    myColor = defaultColor;
  }
  

  void update(Fairy[] allFairies) {
    
    //move the fairy forward at the current angle
    distTravelled += forwardVel;
    
    // calculate new angle
    float deltaAngle = noise((distTravelled + distOffset)* erraticness) - .5;
    deltaAngle *= turnPower;
    angle += deltaAngle;
    if (angle >= 360) angle -= 360;
    if (angle <= 0) angle += 360;
    
    boundaryBounce();
    if (bounceBuffer > 0) bounceBuffer--;
    
    if (debug) drawDebugInfo();
    
    synch(allFairies);
    
    // move the fairy forward
    Vector2 delta = VectorFromAngle(angle);
    pos.sumWith(new Vector2(delta.x * forwardVel, delta.y * forwardVel));
    
    // add the position to the trail
    if (framesElapsed % 6 == 0)
      trail.add(new Vector2(pos));
    if (trail.size() > maxTrail) {
      trail.remove(0);
    }
    renderTrail();
 
    noStroke();
    fill(myColor);
    ellipse(pos.x, pos.y, size, size);
    
    framesElapsed++;
  }
  
  void boundaryBounce() {
    if (bounceBuffer > 0) return;
    if (pos.x < 0 || pos.x > width || pos.y < 0 || pos.y > height) {
      angle += 180;
      bounceBuffer = 10;
    }
  }
  
  
  
  void synch(Fairy[] allFairies) {
    
    totalInfluence = 0;
    
    for (Fairy other : allFairies) {
      
      if (other == this) continue;
      if (other == null) continue;
      
      float distToFairy = dist(other.pos.x, other.pos.y, pos.x, pos.y);
      if ( distToFairy > synchDistance) continue;
        
      // get the degree of influence based on how close they are
      float influence = (synchDistance - distToFairy)/synchDistance;
      totalInfluence += influence;
      
      stroke(255, 0, 255, 50 * influence);
      line(pos.x, pos.y, other.pos.x, other.pos.y);
      
    }
    
    myColor = lerpColor(defaultColor, influenceColor, totalInfluence);
  }
  
  
  void renderTrail() {
    
    for (int i = 0; i < trail.size(); i++) {
      
      Vector2 trailPt = trail.get(i);
      if (trailPt == null) continue;
      fill(defaultColor, 30);
      noStroke();
      float amt = (float)i / trail.size();
      ellipse(trailPt.x, trailPt.y, size * amt, size * amt);
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
