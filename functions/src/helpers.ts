
///DATA
export const converter = <T>() => ({
    toFirestore: (data: Partial<T>) => data,
    fromFirestore: (snap: FirebaseFirestore.QueryDocumentSnapshot) => snap.data() as T
})

