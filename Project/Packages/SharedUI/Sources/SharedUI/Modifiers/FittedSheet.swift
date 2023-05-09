//
//  Created by Emilio Peláez on 11/2/23.
//

import SwiftUI

struct FittedSheetModifier<Item: Identifiable, ItemContent: View>: ViewModifier {
	@Binding var item: Item?
	let onDismiss: () -> Void
	let itemContent: (Item) -> ItemContent
	
	@State private var size: CGSize = .zero
	
	func body(content: Content) -> some View {
		content
			.sheet(item: $item, onDismiss: onDismiss) { item in
				itemContent(item)
					.largePadding()
					.smallPadding(.top)
					.storeSize(in: $size)
					.presentationDetents([.height(size.height)])
					.presentationDragIndicator(.visible)
			}
	}
}

private struct Dummy: Identifiable {
	var id = "Dummy"
}

public extension View {
	func fittedSheet<Item: Identifiable, Content: View>(item binding: Binding<Item?>,
	                                                    onDismiss: @escaping () -> Void = {},
	                                                    content: @escaping (Item) -> Content) -> some View {
		modifier(FittedSheetModifier(item: binding, onDismiss: onDismiss, itemContent: content))
	}
	
	func fittedSheet<Content: View>(isPresented binding: Binding<Bool>,
	                                onDismiss: @escaping () -> Void = {},
	                                content: @escaping () -> Content) -> some View {
		let dummyBinding: Binding<Dummy?> = .init(
			get: { binding.wrappedValue ? Dummy() : nil },
			set: { binding.wrappedValue = $0 != nil ? true : false }
		)
		let fittedSheetModifier = FittedSheetModifier(item: dummyBinding, onDismiss: onDismiss) { _ in
			content()
		}
		return modifier(fittedSheetModifier)
	}
}
