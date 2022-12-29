//
//  ViewController.swift
//  MdFahimFaezAbir-30028
//
//  Created by Bjit on 27/12/22.
//

import UIKit

class ViewController: UIViewController {
    
    
    @IBOutlet weak var startButton: UIButton!
    var xPoint: Double = 600
    @IBOutlet weak var finishLine: UIImageView!
    @IBOutlet weak var blueCar1: UIImageView!
    @IBOutlet weak var blueCar2: UIImageView!
    
    @IBOutlet weak var roadView: UIImageView!
    @IBOutlet weak var blueCar3: UIImageView!
    @IBOutlet weak var blueCar4: UIImageView!
    @IBOutlet weak var yellowCar1: UIImageView!
    @IBOutlet weak var yellowCar2: UIImageView!
    @IBOutlet weak var yellowCar3: UIImageView!
    @IBOutlet weak var yellowCar4: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        //let gif = UIImage.gifImageWithName("7RN4")
        //roadView.image = gif
        blueCar1.image = UIImage(named: "blueCar")
        yellowCar1.image = UIImage(named: "yellowCar")
        finishLine.image = UIImage(named: "finishImage")
        startButton.layer.cornerRadius = 20
        //startButton.layer.backgroundColor =
    }
    @IBAction func startRace(_ sender: Any) {
        startRace()
    }
    func startRace(){
        let mainQueue = DispatchQueue(label: "com.main.queue")
        let alert = UIAlertController(title: "Choose Queue", message: "", preferredStyle: .actionSheet)
        let globalQueue =  UIAlertAction(title: "Global Queue (Concurent Sync)", style: .default){[weak self]_ in
            guard let self = self else {return}
            //self.imagePicker()
            self.blueCar4.image = nil
            self.yellowCar4.image = nil
            mainQueue.async {
                self.globalSync()
            }
        }
        let globalQueue2 =  UIAlertAction(title: "Global Queue (Concurent Async)", style: .default){[weak self]_ in
            guard let self = self else {return}
            self.blueCar4.image = nil
            self.yellowCar4.image = nil
            mainQueue.async {
                self.globalAsync()
            }
        }
        let customSerialSync = UIAlertAction(title: "Custom Serial Queue (Sync)", style: .default){[weak self]_ in
            guard let self = self else {return}
            self.blueCar4.image = nil
            self.yellowCar4.image = nil
            mainQueue.async {
                self.customSerialSync()
            }
        }
        let customSerialAsync = UIAlertAction(title: "Custom Serial Queue (Async)", style: .default){[weak self]_ in
            guard let self = self else {return}
            self.blueCar4.image = nil
            self.yellowCar4.image = nil
            mainQueue.async {
                self.customSerialAsync()
            }
        }
        let customConcurent = UIAlertAction(title: "Custom Concurrent Queue", style: .default){[weak self]_ in
            guard let self = self else {return}
            self.blueCar4.image = nil
            self.yellowCar4.image = nil
            mainQueue.async {
                self.customConCurrent()
            }
        }
        let cancel = UIAlertAction(title: "Cancel", style: .default){_ in
            alert.dismiss(animated: true)
        }
        alert.addAction(globalQueue)
        alert.addAction(globalQueue2)
        alert.addAction(customSerialSync)
        alert.addAction(customSerialAsync)
        alert.addAction(customConcurent)
        alert.addAction(cancel)
        present(alert, animated: true)
        
    }
    
    
}
// MARK: - Global Sync and Async
extension ViewController{
    func globalSync(){
        DispatchQueue.global().sync{
            let blueRand = UInt32.random(in: 1...4)
            sleep(blueRand)
            self.moveBlueCar()
        }
        DispatchQueue.global().sync {
            let yellowRand = UInt32.random(in: 1...4)
            sleep(yellowRand)
            self.moveYellowCar()
        }
    }
    func globalAsync(){
        let blueRand = UInt32.random(in: 1...4)
        let yellowRand = UInt32.random(in: 1...4)
        DispatchQueue.global().async{
            sleep(blueRand)
            self.moveBlueCar()
        }
        DispatchQueue.global().async {
            sleep(yellowRand)
            self.moveYellowCar()
        }
    }
    
    
}
//MARK: - Custom Serial Queue Sync & Async
extension ViewController{
    func customSerialSync(){
        let customSerialQueue = DispatchQueue(label: "com.serial.queue")
        let blueRand = UInt32.random(in: 1...4)
        let yellowRand = UInt32.random(in: 1...4)
        customSerialQueue.sync {
            sleep(blueRand)
            moveBlueCar()
        }
        customSerialQueue.sync {
            sleep(yellowRand)
            moveYellowCar()
        }
    }
    func customSerialAsync(){
        let customSerialQueue = DispatchQueue(label: "com.serial.queue")
        let blueRand = UInt32.random(in: 1...4)
        let yellowRand = UInt32.random(in: 1...4)
        customSerialQueue.async {
            sleep(blueRand)
            self.moveBlueCar()
        }
        customSerialQueue.async {
            sleep(yellowRand)
            self.moveYellowCar()
        }
    }
}
// MARK: - Custom Concurrent Queue
extension ViewController{
    func customConCurrent(){
        let customSerialQueue = DispatchQueue(label: "com.serial.queue", attributes: .concurrent)
        let blueRand = UInt32.random(in: 1...4)
        let yellowRand = UInt32.random(in: 1...4)
        customSerialQueue.async {
            sleep(blueRand)
            self.moveBlueCar()
        }
        customSerialQueue.async {
            sleep(yellowRand)
            self.moveYellowCar()
        }
    }
    
}
// MARK: - Moving Car Section
extension ViewController{
    func blueCar(carState: Int){
        if carState == 1{
            blueCar1.image = UIImage(named: "blueCar")
        }
        else if carState == 2{
            self.blueCar1.image = nil
            // self.view.reloadInputViews()
            self.blueCar2.image = UIImage(named: "blueCar")
        }
        else if carState == 3{
            self.blueCar1.image = nil
            self.blueCar2.image = nil
            // sleep(1)
            self.blueCar3.image = UIImage(named: "blueCar")
        }
        else if carState == 4{
            self.blueCar1.image = nil
            self.blueCar2.image = nil
            self.blueCar3.image = nil
            self.blueCar4.image = UIImage(named: "blueCar")
        }
    }
    func yellowCar(carState: Int){
        if carState == 1{
            self.yellowCar1.image = UIImage(named: "yellowCar")
        }
        else if carState == 2{
            self.yellowCar1.image = nil
            self.yellowCar2.image = UIImage(named: "yellowCar")
        }
        else if carState == 3{
            self.yellowCar1.image = nil
            self.yellowCar2.image = nil
            // sleep(1)
            self.yellowCar3.image = UIImage(named: "yellowCar")
        }
        else if carState == 4{
            self.yellowCar1.image = nil
            self.yellowCar2.image = nil
            self.yellowCar3.image = nil
            self.yellowCar4.image = UIImage(named: "yellowCar")
            //sleep(1)
        }
    }
    func moveBlueCar(){
        let blueCarQueue = DispatchQueue(label: "com.serial.queue")
        
        sleep(UInt32.random(in: 1...2))
        blueCarQueue.async {
            DispatchQueue.main.async {
                self.blueCar(carState: 1)
            }
        }
        sleep(UInt32.random(in: 1...4))
        blueCarQueue.async {
            DispatchQueue.main.async {
                self.blueCar(carState: 2)
            }
        }
        sleep(UInt32.random(in: 1...4))
        blueCarQueue.async {
            DispatchQueue.main.async {
                self.blueCar(carState: 3)
            }
        }
        sleep(UInt32.random(in: 1...4))
        blueCarQueue.async {
            DispatchQueue.main.async {
                self.blueCar(carState: 4)
                //sleep(1)
            }
        }
        //        for _ in 0...99999999{
        //
        //        }
        
    }
    func moveYellowCar(){
        let yellowCarQueue = DispatchQueue(label: "com.serial.queue")
        sleep(UInt32.random(in: 1...2))
        yellowCarQueue.async {
            DispatchQueue.main.async {
                self.yellowCar(carState: 1)
            }
        }
        sleep(UInt32.random(in: 1...4))
        yellowCarQueue.async {
            DispatchQueue.main.async {
                self.yellowCar(carState: 2)
            }
        }
        sleep(UInt32.random(in: 1...4))
        yellowCarQueue.async {
            DispatchQueue.main.async {
                self.yellowCar(carState: 3)
            }
        }
        sleep(UInt32.random(in: 1...4))
        yellowCarQueue.async {
            DispatchQueue.main.async {
                self.yellowCar(carState: 4)
                //sleep(1)
            }
        }
        //        for _ in 0...99999999{
        //
        //        }
        
        
    }
    
}



