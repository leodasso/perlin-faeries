static class Vector2 {
  
  float x;
  float y;
  
  Vector2(float newX, float newY) {
    x = newX;
    y = newY;
  }
  
  Vector2 (Vector2 original) {
    x = original.x;
    y = original.y;
  }
  
  /// Adds the given v2 to this 
  void sumWith(Vector2 other) {
    x += other.x;
    y += other.y;
  }
}
