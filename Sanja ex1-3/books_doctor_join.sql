SELECT patient.fName, doctor.lName, doctor.fName, intervention.date FROM `doctor` JOIN doctorandpatient ON doctor.doctor_id = doctorandpatient.fk_Doktor_id JOIN patient ON patient.patient_id = doctorandpatient.fk_patient_id JOIN intervention ON intervention.intervension_id = doctorandpatient.fk_intervention;

SELECT books_id.name, books_id.author, loan.`start date`, loan.`end date`, reader.lName, reader.fName FROM `books_id` JOIN loan on books_id.book_id = loan.loan_book_id JOIN reader on reader.reader_id = loan.fk_loaner_id;

SELECT books_id.name, books_id.author, loan.`start date`, loan.`end date`, reader.lName, reader.fName FROM `books_id` LEFT JOIN loan on books_id.book_id = loan.loan_book_id LEFT JOIN reader on reader.reader_id = loan.fk_loaner_id;

SELECT books_id.author, books_id.name, loan.`start date`, loan.`end date`, reader.lName, reader.fk_read_id FROM books_id RIGHT JOIN loan on loan.loan_book_id = books_id.book_id RIGHT JOIN reader ON reader.reader_id = loan.fk_loaner_id;

--
