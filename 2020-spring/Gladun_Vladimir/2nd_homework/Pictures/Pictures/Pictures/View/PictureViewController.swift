//
//  PictureViewController.swift
//  Pictures
//
//  Created by Vladimir GL on 03.04.2020.
//  Copyright © 2020 VDTA. All rights reserved.
//

import UIKit

final class PictureViewController: UIViewController {
  @IBOutlet private var tableView: UITableView!
  private var pictures = [Image]() {
    didSet {
      DispatchQueue.main.async {
        self.tableView.reloadData()
      }
    }
  }
  private let pictureService: PictureService = PicturesServiceImpl()
  private let cellIdentifier = "PictureTableViewCell"
  
  override func viewDidLoad() {
    super.viewDidLoad()
    pictureService.getPictures {
      guard let pictures = $0 else { return }
      self.pictures = pictures
    }
    tableView.rowHeight = 260
  }
}

extension PictureViewController: UITableViewDelegate {
  func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
    guard indexPath.row == pictures.count - 1 else { return }
    pictureService.getMorePictures {
      guard let pictures = $0 else { return }
      self.pictures.append(contentsOf: pictures)
    }
  }
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    guard let viewController = UIStoryboard(name: "Main", bundle: nil)
      .instantiateViewController(withIdentifier:"PictureDetailViewController") as?
      PictureDetailViewController else {
        return
    }
    viewController.picture = pictures[indexPath.row]
    navigationController?.pushViewController(viewController, animated: true)
    tableView.deselectRow(at: indexPath, animated: true)
  }
}

extension PictureViewController: UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    pictures.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? PictureTableViewCell else {
      fatalError("TableView wasn't configured")
    }
    let picture = pictures[indexPath.row]
    cell.setup(with: picture)
    return cell
  }
}
