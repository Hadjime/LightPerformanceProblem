using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public interface IInputSender
{
   public abstract event System.Action<Vector2> OnInput;
}
