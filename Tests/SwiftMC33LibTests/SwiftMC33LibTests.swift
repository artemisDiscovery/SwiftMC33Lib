import Foundation

import XCTest
@testable import SwiftMC33Lib


final class SwiftMC33LibTests: XCTestCase {
    func testExample() throws {
        // XCTest Documentation
        // https://developer.apple.com/documentation/xctest

        // Defining Test Cases and Test Methods
        // https://developer.apple.com/documentation/xctest/defining_test_cases_and_test_methods
    }

    func testSurface() throws {

        // make test data per author's example 

        var nx:UInt32 = 201
        var ny:UInt32 = 201
        var nz:UInt32 = 201

        let ptr_r0 = UnsafeMutablePointer<Double>.allocate(capacity: 3)
        ptr_r0.initialize(repeating: -4.0, count: 3)
        defer {
            ptr_r0.deinitialize(count: 3)
            ptr_r0.deallocate()
        }

        let r0 = UnsafeMutableBufferPointer(start:ptr_r0, count:3 )

        let ptr_d = UnsafeMutablePointer<Double>.allocate(capacity: 3)
        ptr_d.initialize(repeating: 0.04, count: 3)
        defer {
            ptr_d.deinitialize(count: 3)
            ptr_d.deallocate()
        }

        let d = UnsafeMutableBufferPointer(start:ptr_d, count:3 )
        
        let count = 201*201*201
        let ptr = UnsafeMutablePointer<GRD_data_type>.allocate(capacity: count)
        ptr.initialize(repeating: 0.0, count: count)
        defer {
            ptr.deinitialize(count: count)
            ptr.deallocate()
        }

        let data = UnsafeMutableBufferPointer(start:ptr, count:count )

        var l = 0;
        for k in 0..<Int(nz) 
        {
            let z = r0[2] + Double(k)*d[2];
            for j in 0..<Int(ny)
            {
                let y = r0[1] + Double(j)*d[1];
                for i in 0..<Int(nx)
                {
                    let x = r0[0] + Double(i)*d[0];
                    data[l] = cos(x) + cos(y) + cos(z);
                    l += 1
                }
            }
        }


        var G:UnsafeMutablePointer<_GRD> = grid_from_data_pointer(nx, ny, nz, ptr_r0, ptr_d, ptr) 
	
        var M:UnsafeMutablePointer<MC33> = create_MC33(G)

        var S:UnsafeMutablePointer<surface> = calculate_isosurface(M, 0.5)

        let nV = S.pointee.nV
        let nT = S.pointee.nT 

        let V = S.pointee.V
        let N = S.pointee.N 
        let T = S.pointee.T

        print("\nHave \(nV) vertices and \(nT) elements")

        // write out in obj format


        
        let url = URL(fileURLWithPath: "./isosurface.obj")

        var outstr = ""

        for iv in 0..<Int(nV) {
            outstr += "v \(V![iv].0) \(V![iv].1) \(V![iv].2)\n"
        }

        
        for iv in 0..<Int(nV) {
            outstr += "vn \(N![iv].0) \(N![iv].1) \(N![iv].2)\n"
        }

        for ie in 0..<Int(nT) {
            outstr += "f \(T![ie].0+1) \(T![ie].1+1) \(T![ie].2+1)\n"
        }
        

        do {
            try outstr.write(to: url, atomically: true, encoding: String.Encoding.utf8)
        } catch {
            print("error writing file \(url)")
        }

        print("wrote file to path \(url)")


    
    





	
    }
}
