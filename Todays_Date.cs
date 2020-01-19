using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UI;
using UnityEngine.SceneManagement;

public class Todays_Date : MonoBehaviour
{
 
    [SerializeField] Text todaysDate;

    string timeAndDate = System.DateTime.Now.ToString("MM/dd/y");

    // Start is called before the first frame update
    void Start()
    {
        PlayerPrefs.SetString("date", timeAndDate);
        todaysDate.text = "Today's date: "+ timeAndDate;

    }
    void Update()
    {
        //   countdownText = timeAndDate;
    }
    public void addDateAndDataToLog()
    {
     //   GameObject newLog = (GameObject)Instantiate(Resources.Load("logTheDateAndOunce"));

    }
}