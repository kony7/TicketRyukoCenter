//
//  MakeTicketViewController.swift
//  TicketRyukoCenter
//
//  Created by SeinaKonishi on 2022/03/07.
//

import UIKit

class MakeTicketViewController: UIViewController {
    
    @IBOutlet var designCard1: UIButton!
    @IBOutlet var designCard2: UIButton!
    @IBOutlet var designCard3: UIButton!
    @IBOutlet var designCard4: UIButton!
    
    @IBOutlet var titleTextField:UITextField!
    @IBOutlet var senderTextField:UITextField!
    @IBOutlet var comentTextField:UITextField!
    
    @IBOutlet var limitDatePicker: UIDatePicker!
    
    var cardSelecte:Int = 0
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        titleTextField.setUnderLine()
        senderTextField.setUnderLine()
        comentTextField.setUnderLine()
        
        // Do any additional setup after loading the view.
    }
    
    @IBAction func pinkButton(){
        cardSelecte = 1
    }
    
    @IBAction func orangeButton(){
        cardSelecte = 2
    }
    
    @IBAction func greenButton(){
        cardSelecte = 3
    }
    
    @IBAction func blueButton(){
        cardSelecte = 4
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {

         // segueのIDを確認して特定のsegueのときのみ動作させる
         if segue.identifier == "toSendViewController" {
             // 2. 遷移先のViewControllerを取得
             let next = segue.destination as? SendViewController
             // 3. １で用意した遷移先の変数に値を渡す
             next?.titleText = self.titleTextField.text!
             next?.senderText = self.senderTextField.text!
             next?.comentText = self.comentTextField.text!
             next?.limitDate = self.limitDatePicker.date
             next?.design = self.cardSelecte
             
         }
     }

     @IBAction func tapTransitionButton(_ sender: Any) {
         // 4. 画面遷移実行
         performSegue(withIdentifier: "toSendViewController", sender: nil)
     }

    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension UITextField {
    func setUnderLine() {
        // 枠線を非表示にする
        borderStyle = .none
        let underline = UIView()
        // heightにはアンダーラインの高さを入れる
        underline.frame = CGRect(x: 0, y: frame.height, width: frame.width, height: 0.5)
        // 枠線の色
        underline.backgroundColor = .gray
        addSubview(underline)
        // 枠線を最前面に
        bringSubviewToFront(underline)
    }
}
