using Godot;
using System;

public partial class player_controller : CharacterBody2D
{
    [Export]
    public float speed = 2;
    
    public void _PhysicsProcess(float delta)
    {
        base._PhysicsProcess(delta);
        
    }
    
    
}
