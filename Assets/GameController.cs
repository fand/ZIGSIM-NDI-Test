using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UI;
using Klak.Ndi;

public class GameController : MonoBehaviour
{
    [SerializeField] Text _info;
    [SerializeField] NdiReceiver _receiver;

    void Update()
    {
        _info.text = string.Format(
            "Source: {0}\nResolution: {1} x {2}",
            _receiver.sourceName,
            _receiver.width,
            _receiver.height
        );
    }
}
