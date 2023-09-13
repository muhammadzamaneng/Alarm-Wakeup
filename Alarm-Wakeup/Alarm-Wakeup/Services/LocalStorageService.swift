//
//  LocalStorageService.swift
//  Alarm-Wakeup
//
//  Created by Dev on 3/26/23.
//

import Foundation
import CoreData
protocol HasLocalStorageService {
    var localStorageService: LocalStorageService { get }
}

protocol CoreDataCodable {
    static func from(fromCoreData: NSManagedObject)
    func toCoreDataEntity(context: NSManagedObjectContext) -> NSManagedObject
}

class LocalStorageService {
    let container: NSPersistentContainer
    var context: NSManagedObjectContext {
        container.viewContext
    }

    init(containerName: String) {
        self.container = NSPersistentContainer(name: containerName)
        container.loadPersistentStores { decription, error in
            if let error = error {
                print("Core data failed to load \(error)")
            }
            print("Debug: \(decription)")
        }
    }

    func fetchData<T: NSManagedObject>(entity: T.Type, completionHandler: @escaping (Result<[T], Error>) -> Void) {
        Task {
            do {
                let result = try await fetch(entity: entity)
                completionHandler(.success(result))
            } catch {
                print("Error: while fetching \(error)")
                completionHandler(.failure(error))
            }
        }
    }

    func updateData(id: UUID, value: Bool, completionHandler: @escaping (Result<Bool, Error>) -> Void) {
        Task {
            do {
                let result = try await fetch(entity: AlarmEntity.self, predicate: NSPredicate(format: "id = %@", id as CVarArg), limit: 1).first
                result!.isActive = value
                completionHandler(.success(true))
            } catch {
                print("Error: while updating \(error)")
                completionHandler(.failure(error))
            }
        }
    }

    func addData(_ model: CoreDataCodable) throws {
        _ = model.toCoreDataEntity(context: context)
        try save()
    }

}

// Private method

extension LocalStorageService {

    private func fetch<T: NSManagedObject>(entity: T.Type, predicate: NSPredicate? = nil, limit: Int? = nil) async throws -> [T] {
        let request = NSFetchRequest<T>(entityName: "\(entity)")
        if let predicate = predicate { request.predicate = predicate }
        if let limit = limit { request.fetchLimit = limit }
        return try context.fetch(request)
    }

    private func save() throws {
        try context.save()
    }
}
