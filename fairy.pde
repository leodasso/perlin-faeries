class Vector2 {
  
  float x;
  float y;
  
  Vector2(float newX, float newY) {
    x = newX;
    y = newY;
  }
  
  /// Adds the given v2 to this 
  void sumWith(Vector2 other) {
    x += other.x;
    y += other.y;
  }
}

class Fairy {
  
  Fairy(Vector2 startPos) {
    pos = startPos;
  }
  
  Vector2 pos;
  Vector2 vel;
  float size = 5;
  
  void update() {
    
    fill(0, 0, 255);
    ellipse(pos.x, pos.y, size, size);
  }
  
}
