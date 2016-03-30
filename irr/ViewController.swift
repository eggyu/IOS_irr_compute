//
//  ViewController.swift
//  irr
//
//  Created by abreu on 2016/3/25.
//  Copyright © 2016年 abreu. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate  {

    /*
     *變數
     */
    var dataList=Array<Double>()
    
     let MINDIF = 0.001

     let LOOPNUM = 2000
    
      let period = 0
    
    @IBOutlet weak var ansTV: UILabel!
    
    @IBOutlet weak var editTV: UITextField!
    
    @IBOutlet weak var listView: UITableView!

    
    /*
     *
     */
    override func viewDidLoad() {
        super.viewDidLoad()
       
        // Do any additional setup after loading the view, typically from a nib.
        listView.dataSource = self
        listView.delegate = self
    }

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    /*
     * view
     */
    @IBAction func addBT(sender: UIButton) {
        if (!editTV.text!.isEmpty  ){
            
            dataList.append(-Double.abs( NSNumberFormatter().numberFromString(editTV.text!)!.doubleValue ))
                listView.reloadData()
           
        }
    }

    @IBAction func getBT(sender: UIButton) {
    
        
        if (!editTV.text!.isEmpty){
            dataList.append(Double.abs( NSNumberFormatter().numberFromString(editTV.text!)!.doubleValue ))
        
           listView.reloadData()
        }
        
        
          }
 
    @IBAction func deleteBT(sender: UIButton) {
        dataList.removeLast()
        listView.reloadData()
    }
    
    @IBAction func reportBT(sender: UIButton) {
        
        var dataArray = UnsafeMutablePointer<Double>.alloc(dataList.count)
        
        var i = 0
        for data in dataList{
            
           
            dataArray[i]=data
            i+=1
        }
           
    
        
      var size  = Int32 (dataList.count)
     
        
        let data = computeIRR(&dataArray,&size)
     
        if (data ==  2.0 || data == -2.0){ansTV.text="NaN"
                  }else{
             ansTV.text="\(data*100) %"

        }

    }
    
    @IBAction func resetBT(sender: UIButton) {
        editTV.text=""
        ansTV.text=""
        dataList.removeAll()
              listView.reloadData()
    }
    
       //宣告這個UITableView畫面上的控制項總共有多少Row
    func tableView(tableView: UITableView, numberOfRowsInSection section:Int) -> Int {
        return dataList.count
    }
    
    //填充UITableViewCell中文字標簽的值
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell: UITableViewCell = UITableViewCell(style: UITableViewCellStyle.Subtitle, reuseIdentifier: "Cell")
        
        if (dataList[indexPath.row] < 0 ){
            cell.textLabel!.textColor = UIColor.redColor()
        cell.textLabel!.text = "\(-dataList[indexPath.row])"
        }else{
             cell.textLabel!.textColor = UIColor.blackColor()
             cell.textLabel!.text = "\(dataList[indexPath.row])"
        }
        return cell
    }
    
    
    


    
  
    
  }

